from flask import Flask, request, send_from_directory
from flask_restful import Resource, Api, abort
from glob import glob
from PIL import Image
from io import BytesIO
import helpers
import base64
import os
import json
import face_recognition
import pickle
import numpy
import logging


# log = logging.getLogger('werkzeug')
# log.setLevel(logging.ERROR)


def abort_if_not_exists(patient_id):
    all_patients = glob("database/*.json")
    if not f"database/{patient_id}.json" in all_patients:
        abort(404)


def get_new_id():
    all_patients = glob("database/*.json")
    if not all_patients:
        return "1"

    all_patients.sort()
    last_id = os.path.splitext(os.path.basename(all_patients[-1]))
    return str(int(last_id[0]) + 1)


def save_face_data(patient_id, image_data):
    if os.path.exists("static/face_data.dat"):
        with open("static/face_data.dat", "rb") as f:
            all_face_data = pickle.load(f)
    else:
        all_face_data = {}

    image = Image.open(BytesIO(image_data))
    face_data = face_recognition.face_encodings(numpy.array(image))[0]
    all_face_data[patient_id] = face_data

    with open("static/face_data.dat", "wb") as f:
        pickle.dump(all_face_data, f)


def delete_face_data(patient_id):
    with open("static/face_data.dat", "rb") as f:
        all_face_data = pickle.load(f)

    del all_face_data[patient_id]

    with open("static/face_data.dat", "wb") as f:
        pickle.dump(all_face_data, f)


def delete_all_face_data():
    with open("static/face_data.dat", "rb") as f:
        all_face_data = pickle.load(f)

    all_face_data = {}

    with open("static/face_data.dat", "wb") as f:
        pickle.dump(all_face_data, f)


class Patients(Resource):
    def get(self):
        all_patient_files = glob("database/*.json")

        return json.dumps(helpers.get_paginated_list(
            all_patient_files,
            "/patients",
            start=request.args.get("start", 1),
            limit=request.args.get("limit", 20)
        ))

    def delete(self):
        all_patient_files = glob("database/*.json")
        all_image_files = glob("static/images/*.jpg")

        for f in all_patient_files + all_image_files:
            os.remove(f)

        delete_all_face_data()

        return "", 204


class Patient(Resource):
    def get(self, patient_id):
        abort_if_not_exists(patient_id)
        return open(f"database/{patient_id}.json", "r").read()

    def delete(self, patient_id):
        abort_if_not_exists(patient_id)
        delete_face_data(patient_id)
        os.remove(f"database/{patient_id}.json")
        os.remove(f"static/images/{patient_id}.jpg")
        return"", 204

    def put(self, patient_id):
        data = request.form.to_dict()
        if "image" in data:
            image_data = base64.b64decode(data["image"])
            save_face_data(patient_id, image_data)
            data.pop("image", None)
            with open(f"static/images/{patient_id}.jpg", "wb") as image_file:
                image_file.write(image_data)

        patient_data = json.loads(
            open(f"database/{patient_id}.json", "r").read())
        patient_data.update(data)

        with open(f"database/{patient_id}.json", "w") as patient_file:
            patient_file.write(json.dumps(patient_data))
        return f"{request.form}", 201


class AddPatient(Resource):
    def post(self):
        data = request.get_json()
        patient_id = get_new_id()
        data["id"] = patient_id
        image_data = base64.b64decode(data["image"])
        data.pop("image", None)
        save_face_data(patient_id, image_data)

        with open(f"static/images/{patient_id}.jpg", "wb") as image_file:
            image_file.write(image_data)
            data["image_url"] = f"images/{patient_id}"

        with open(f"database/{patient_id}.json", "w") as patient_file:
            patient_file.write(json.dumps(data))

        return "SUCCESS!!!", 201


class CheckPatient(Resource):
    def get(self):
        tolerance = float(request.args.get("tolerance", 0.6))
        b64string = request.args.get("image")
        with open("static/face_data.dat", "rb") as f:
            all_face_data = pickle.load(f)

        print(len(all_face_data))

        all_face_ids = list(all_face_data.keys())
        all_face_encodings = numpy.array(list(all_face_data.values()))
        face_image = numpy.array(Image.open(
            BytesIO(base64.b64decode(b64string))))

        matches = face_recognition.compare_faces(
            all_face_encodings, face_recognition.face_encodings(face_image), tolerance=tolerance)

        data = []
        for i, match in enumerate(matches):
            if match:
                with open(f"database/{all_face_ids[i]}.json") as patient_file:
                    patient_data = patient_file.read()
                    data.append(patient_data)

        return json.dumps(data)


class Stats(Resource):
    def get(self):
        data = []
        patient_files = glob("database/*.json")
        data.append(len(patient_files))
        positive = 0
        for f in patient_files:
            d = json.loads(open(f, "r").read())
            if d["positive"]:
                positive += 1
        data.append(positive)
        return json.dumps(data)


app = Flask(__name__)
api = Api(app)

api.add_resource(AddPatient, "/add_patient")
api.add_resource(Patients, "/patients")
api.add_resource(Patient, "/patients/<patient_id>")
api.add_resource(CheckPatient, "/check_patient")
api.add_resource(Stats, "/stats")


@app.route("/")
def say_hello():
    return "Hello world!"


@app.route("/images/<id>")
def get_image(id):
    return app.send_static_file(f"images/{id}.jpg")


if __name__ == "__main__":
    app.run(debug=True)
