(function (root, factory) {
	if (typeof exports === 'object') {
		module.exports = factory();
	} else if (typeof define === 'function' && define.amd) {
		define('uxhr', factory);
	} else {
		root.uxhr = factory();
	}
}(this, function () {

	return function (url, data, options) {

		data = data || '';
		options = options || {};

		var complete = options.complete || function(){},
			success = options.success || function(){},
			error = options.error || function(){},
			headers = options.headers || {},
			method = options.method || 'GET',
			sync = options.sync || false,
			req = (function() {
				return XMLHttpRequest ? new XMLHttpRequest() : (ActiveXObject ? new ActiveXObject('Microsoft.XMLHTTP') : 0);
			})();

		if (!req) {
			throw new Error ('Browser doesn\'t support XHR');
		}

		// serialize data?
		if (typeof data !== 'string') {
			var serialized = [];
			for (var datum in data) {
				serialized.push(datum + '=' + data[datum]);
			}
			data = serialized.join('&');
		}

		// set timeout
		req.ontimeout = +options.timeout || 0;

		// listen for XHR events
		req.onreadystatechange = function () {
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
		req.open(method, (method==='GET' ? url+'?'+data : url), sync);

		// 2. set headers
		for (var header in headers) {
			req.setRequestHeader(header, headers[header]);
		}

		// 3. send it
		req.send(method!=='GET'?data:null);
	};

}));