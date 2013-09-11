function uxhr (url, data, options) {

	var _data = data || '',
		_options = options || {},
		complete = _options.complete || function(){},
		success = _options.success || function(){},
		error = _options.error || function(){},
		headers = _options.headers || {},
		method = _options.method || 'GET',
		req = (function() {
			return XMLHttpRequest ? new XMLHttpRequest() : (ActiveXObject ? new ActiveXObject('Microsoft.XMLHTTP') : 0);
		})();

	if (!req) {
		throw new Error ('Browser doesn\'t support XHR');
	}

	// serialize data?
	if (typeof _data !== 'string') {
		var serialized = [];
		for (var d in _data) {
			serialized.push(d + '=' + _data[d]);
		}
		_data = serialized.join('&');
	}

	// set timeout
	req.ontimeout = +_options.timeout || 0;

	// listen for XHR events
	req.onreadystatechange = function (e) {
		if (req.readyState === 4) {

			var response = req.responseText,
				status = req.status;

			if (status < 400) {
				success(response);
			} else {
				error(response, status);
			}

			complete(response, status);
		}
	};

	// 1. open connection
	req.open(method, (method==='GET' ? url+'?'+_data : url));

	// 2. set headers
	for (var header in headers) {
		req.setRequestHeader(header, headers[headers]);
	}

	// 3. send it
	req.send(method!=='GET'?_data:null);
}