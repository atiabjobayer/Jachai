import face_recognition
import requests
import base64
import numpy
import PIL
from io import BytesIO
from pprint import pprint
from json import loads

with open("walid2.jpg", "rb") as f:
    purno = base64.b64encode(f.read())


p = requests.get("http://127.0.0.1:5000/check_patient",
                 data={"image": purno, "tolerance": 0.5})

pprint(loads(p.json()))
