define(function (require, exports, module) {

	function uxhr (url, data, options) {

		var callback = options.complete || function(){},
			headers = options.headers,
			method = options.method || 'GET',
			req = (function() {
				return XMLHttpRequest ? new XMLHttpRequest() : (ActiveXObject ? new ActiveXObject('Microsoft.XMLHTTP') : 0);
			})();

		if (!req) {
			throw new Error ('Browser doesn\'t support XHR');
		}

		// serialize data?
		if (data && typeof data !== 'string') {
			var serialized = [];
			for (var d in data) {
				serialized.push(d + '=' + data[d]);
			}
			data = serialized.join('&');
		}

		// listen for XHR events
		req.onreadystatechange = function (e) {
			if (req.readyState === 4) {
				callback(req.responseText);
			}
		};

		// 1. open connection
		req.open(method, (method==='GET' ? url+'?'+data : url));

		// 2. set headers
		if (headers) {
			for (var header in headers) {
				req.setRequestHeader(header, headers[headers]);
			}
		}

		// 3. send it
		req.send(method==='POST'?data:null);
	}

	return uxhr;

});