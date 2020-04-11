# coding=utf-8
from __future__ import absolute_import
from __future__ import unicode_literals

import json
import requests
import requests.packages.urllib3.exceptions
from RequestsLibrary import RequestsKeywords
from robot.api import logger
from robot.libraries.OperatingSystem import OperatingSystem
from .Data import Data
from .Headers import Headers
from .Json2Object import Json2Object
from .Parameters import Parameters
from .Status import Status

import sys
import os
curPath = os.path.abspath(os.path.dirname(__file__))
rootPath = os.path.split(curPath)[0]
sys.path.append(rootPath)



class FapiKeywords(object):
    ROBOT_LIBRARY_SCOPE = 'Global'

    def __init__(self):
        self.params = Parameters()
        self.headers = Headers(APITEST="1")
        self.data = Data()
        self.requestBody = None
        self.status = Status()
        self.requestsKW = RequestsKeywords()
        self.fapiResponse = ''
        self.os = OperatingSystem()
        self.toObj = Json2Object()

    def fapi_headers_set(self, *key_value_pairs, **items):
        """Adds the given ``key_value_pairs`` and ``items`` to HTTP request headers.

        Giving items as ``key_value_pairs`` means giving keys and values
        as separate arguments:

        | Fapi Headers Set | key | value | second | ${2} |
        =>
        | headers = {'a': 1, 'key': 'value', 'second': 2}

        Starting from Robot Framework 2.8.1, items can also be given as kwargs
        using ``key=value`` syntax:

        | Fapi Headers Set |  key=value | second=${2} |

        The latter syntax is typically more convenient to use, but it has
        a limitation that keys must be strings.

        If given keys already exist in request headers, their values are updated.
        """
        self.headers.set(*key_value_pairs, **items)

    def fapi_headers_to_dictionary(self):
        """ Return all headers as a dictionary """
        return self.headers.to_dictionary()

    def fapi_headers_reset(self):
        """ Reset request headers """
        self.headers.reset()
        self.headers.set(APITEST="1")

    def fapi_params_set(self, *key_value_pairs, **items):
        """Adds the given ``key_value_pairs`` and ``items`` to HTTP request parameters.

        Giving items as ``key_value_pairs`` means giving keys and values
        as separate arguments:

        | Fapi Params Set | key | value | second | ${2} |
        =>
        | parameters = {'a': 1, 'key': 'value', 'second': 2}

        Starting from Robot Framework 2.8.1, items can also be given as kwargs
        using ``key=value`` syntax:

        | Fapi Params Set |  key=value | second=${2} |

        The latter syntax is typically more convenient to use, but it has
        a limitation that keys must be strings.

        If given keys already exist in request parameters, their values are updated.
        """
        self.params.set(*key_value_pairs, **items)

    def fapi_params_to_dictionary(self):
        """ Return all request parameters as a dictionary """
        return self.params.to_dictionary()

    def fapi_params_reset(self):
        """ Reset request parameters """
        self.params.reset()
        self.headers.set(APITEST="1")

    def fapi_create_session(self, alias, url, timeout=None):
        """ Fapi Create Session: create a HTTP session to a server

        ``alias`` Robot Framework alias to identify the session

        ``url`` Base url of the server

        ``timeout`` Connection timeout
        """
        fapiHeaders = self.fapi_headers_to_dictionary()
        self.requestsKW.create_session(
            alias,
            url,
            fapiHeaders,
            timeout=timeout)

    def fapi_post(self, alias, uri, data=None, timeout=None):
        """ Send a POST request on the session object found using the
        given `alias`

        ``alias`` that will be used to identify the Session object in the cache

        ``uri`` to send the POST request to

        ``data`` a dictionary of key-value pairs that will be urlencoded
               and sent as POST data
               or binary data that is sent as the raw body content

        ``timeout`` Connection timeout
        """
        self.requestBody = data
        fapiHeaders = self.fapi_headers_to_dictionary()
        fapiParams = self.fapi_params_to_dictionary()
        fBodyData, fParams = self._format_data_according_to_header(alias, fapiParams, fapiHeaders)
        self.fapiResponse = self.requestsKW.post_request(
            alias,
            uri,
            data=fBodyData,
            params=fParams,
            headers=fapiHeaders,
            timeout=timeout)
        self.fapi_log_json(self.fapiResponse.content)
        self.fapi_params_reset()

    def fapi_post_files(self, alias, uri, filesDict, data=None, timeout=None):
        """ Upload a file to file server.

        ``alias`` that will be used to identify the Session object in the cache

        ``uri`` to send the POST request to

        ``filesDict`` a dictionary of file names containing file data to POST to the server

        ``data`` a dictionary of key-value pairs that will be urlencoded
               and sent as POST data
               or binary data that is sent as the raw body content

        ``timeout`` Connection timeout
        """
        self.requestBody = data
        fapiHeaders = self.fapi_headers_to_dictionary()
        fapiParams = self.fapi_params_to_dictionary()
        fBodyData, fParams = self._format_data_according_to_header(alias, fapiParams, fapiHeaders)
        self.fapiResponse = self.requestsKW.post_request(
            alias,
            uri,
            data=fBodyData,
            params=fParams,
            files=filesDict,
            headers=fapiHeaders,
            timeout=timeout)

        self.fapi_log_json(self.fapiResponse.content)
        self.fapi_params_reset()

    def fapi_get(self, alias, uri, timeout=None):
        """ Send a GET request on the session object found using the
        given `alias`

        ``alias`` that will be used to identify the Session object in the cache

        ``uri`` to send the GET request to

        ``timeout`` Connection timeout
        """
        fapiHeaders = self.fapi_headers_to_dictionary()
        fapiParams = self.fapi_params_to_dictionary()
        self.fapiResponse = self.requestsKW.get_request(
            alias,
            uri,
            params=fapiParams,
            headers=fapiHeaders,
            timeout=timeout)
        self.fapi_log_json(self.fapiResponse.content)
        self.fapi_params_reset()

    def fapi_put(self, alias, uri, data=None, timeout=None):
        """ Send a PUT request on the session object found using the
        given `alias`

        ``alias`` that will be used to identify the Session object in the cache

        ``uri`` to send the PUT request to

        ``data`` a dictionary of key-value pairs that will be urlencoded
               and sent as POST data
               or binary data that is sent as the raw body content

        ``timeout`` Connection timeout
        """
        self.requestBody = data
        fapiHeaders = self.fapi_headers_to_dictionary()
        fapiParams = self.fapi_params_to_dictionary()
        fBodyData, fParams = self._format_data_according_to_header(alias, fapiParams, fapiHeaders)
        self.fapiResponse = self.requestsKW.put_request(
            alias,
            uri,
            data=fBodyData,
            params=fParams,
            headers=fapiHeaders,
            timeout=timeout)
        self.fapi_log_json(self.fapiResponse.content)
        self.fapi_params_reset()

    def fapi_delete(self, alias, uri, timeout=None):
        """ Send a DELETE request on the session object found using the
        given `alias`

        ``alias`` that will be used to identify the Session object in the cache

        ``uri`` to send the DELETE request to

        ``timeout`` Connection timeout
        """
        fapiHeaders = self.fapi_headers_to_dictionary()
        fapiParams = self.fapi_params_to_dictionary()
        self.fapiResponse = self.requestsKW.delete_request(
            alias,
            uri,
            params=fapiParams,
            headers=fapiHeaders,
            timeout=timeout)
        self.fapi_log_json(self.fapiResponse.content)
        self.fapi_params_reset()

    def fapi_delete_all_sessions(self):
        """ Removes all the session objects """
        self.requestsKW.delete_all_sessions()

    def fapi_request_should_be_succeed(self):
        """ Fapi HTTP response code should be 200 (means success) """
        print("HTTP response code is " + str(self.fapiResponse.status_code))
        assert self.fapiResponse.status_code == 200

    def fapi_response_code(self):
        """ Return Fapi HTTP response code
        """
        return self.fapiResponse.status_code

    def fapi_data_to_object(self):
        """ Convert Fapi response content to python object """
        if self.fapiResponse.content is None:
            return None
        obj = self.toObj.json_to_object(self.fapiResponse.content)
        return obj.data

    def fapi_response_data(self):
        """ Return Fapi response data """
        if self.fapiResponse.content is None:
            return None
        obj = json.loads(self.fapiResponse.content)
        data = obj['data']
        return data

    def fapi_response_data_to_object(self):
        """ Convert Fapi response content to python object """
        if self.fapiResponse.content is None:
            return None
        obj = self.toObj.json_to_object(self.fapiResponse.content)
        return obj

    def fapi_response_headers_to_dict(self):
        """ Convert Fapi response headers to dictionary """
        return self.fapiResponse.headers

    def fapi_data_field_count(self, pointer):
        """ Get element count specified by object pointer """
        return self.data.field_count(pointer)

    def fapi_data_field_count_should_be(self, pointer, expectedValue):
        """ Element count specified by object pointer should be equal to the given `expectedValue`

        ``expectedValue`` is the expected value of element count
        """
        actualValue = self.data.field_count(pointer)
        self.fapi_log("Actual value is: " + str(actualValue))
        assert actualValue == int(expectedValue)

    def fapi_data_field_count_should_not_be(self, pointer, expectedValue):
        """ Element count specified by object pointer should not be equal to the given `expectedValue`

        ``expectedValue`` is the not-expected value of element count
        """
        actualValue = self.data.field_count(pointer)
        assert actualValue != int(expectedValue)

    def fapi_status_should_be_succeed(self):
        """ Fapi response status code should be 0 (means success) """
        dataObj = self.toObj.json_to_object(self.fapiResponse.content)
        assert self.status.status_code(dataObj) == 0

    def fapi_status_should_be(self, expectedCode):
        """ Fapi response status code should be equal to the `expectedCode`

        ``expectedCode`` is the expected Fapi response status code
        """
        dataObj = self.toObj.json_to_object(self.fapiResponse.content)
        self.fapi_log("Actual status code is: " + str(self.status.status_code(dataObj)))
        assert self.status.status_code(dataObj) == int(expectedCode)

    def fapi_status_should_not_be(self, expectedCode):
        """ Fapi response status code should not be equal to the `expectedCode`

        ``expectedCode`` is the not-expected Fapi response status code

        """
        dataObj = self.toObj.json_to_object(self.fapiResponse.content)
        self.fapi_log("Actual status code is: " + str(self.status.status_code(dataObj)))
        assert self.status.status_code(dataObj) != int(expectedCode)

    def fapi_log_json(self, jsonStr):
        """ Log json strings to test report """
        try:
            json_ = json.loads(jsonStr)
            isFirstLine = True
            for line in json.dumps(json_, indent=2, ensure_ascii=False).split('\n'):
                if isFirstLine:
                    logger.write("JSON string is : " + line)
                    isFirstLine = False
                else:
                    logger.write(line)
        except Exception:
            pass

    def fapi_log(self, message, repr=False):
        """ Log `message` to test report """
        logger.write(message)

    def _format_data_according_to_header(self, alias, ftParams, headers):
        bodyData = None
        params = None

        if self.requestBody is not None and ftParams:
            bodyData = self.requestBody
            params = ftParams
        elif self.requestBody is not None:
            bodyData = self.requestBody
        else:
            if headers is not None and 'Content-Type' in headers and \
                    headers['Content-Type'].find("application/json") != -1:
                bodyData = ftParams
            elif headers is not None and 'Content-Type' in headers and \
                    headers['Content-Type'].find("application/x-www-form-urlencoded") != -1:
                params = ftParams

        return bodyData, params
