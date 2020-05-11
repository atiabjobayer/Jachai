from flask import abort
import json


def get_paginated_list(files, url, start, limit):
    start = int(start)
    limit = int(limit)
    count = len(files)
    if count < start or limit < 0:
        abort(404)

    obj = {}
    obj['start'] = start
    obj['limit'] = limit
    obj['count'] = count

    if start == 1:
        obj['previous'] = ''
    else:
        start_copy = max(1, start - limit)
        limit_copy = start - 1
        obj['previous'] = url + '?start=%d&limit=%d' % (start_copy, limit_copy)
    if start + limit > count:
        obj['next'] = ''
    else:
        start_copy = start + limit
        obj['next'] = url + '?start=%d&limit=%d' % (start_copy, limit)
    
    results = []
    for f in files[(start - 1):(start - 1 + limit)]:
        with open(f, 'r') as data:
            results.append(json.loads(data.read()))

    obj['results'] = results
    
    return obj
