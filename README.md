#µXHR

The teeny tiny cross-browser XHR library - just 493 bytes gzipped!

##Usage

```js
// with a data object
uxhr('endpoint.html', {
	foo: 'bar',
	baz: 5
}, {
	complete: function (response) { ... }
});

// ... or with a data string
uxhr('endpoint.html', 'war=peace&freedom=slavery&ignorance=strength', {
	complete: function (response) { ... }
});
```

##Arguments

| Argument		| Type				| Required		|
|---------------|-------------------|---------------|
| url			| String			| Yes			|
| data			| String | Object	| No			|
| options		| Object			| No			|

##Options

| Option		| Type		| Default		| Notes									|
|---------------|-----------|---------------|---------------------------------------|
| method		| String	| `GET`			| `GET`, `POST`, `HEAD`, `PUT`, `DELETE`, etc. see [wikipedia.org/wiki/HTTP#Request_methods](http://en.wikipedia.org/wiki/HTTP#Request_methods) |
| headers		| Object	| `{}`			| Custom headers for this request, see [wikipedia.org/wiki/List_of_HTTP_header_fields#Requests](http://en.wikipedia.org/wiki/List_of_HTTP_header_fields#Requests) |
| sync			| Boolean	| false			| Should this request be synchronous? |
| timeout		| Number	| `0`			| Timeout (in ms) before aborting the request |
| complete		| Function	| `function(){}`| Callback fired when the request is completed |
| success		| Function	| `function(){}`| Callback fired when the request is completed successfully (eg. with HTTP status code < 400) |
| error			| Function	| `function(){}`| Callback fired when the request returns an error (eg. HTTP status code >= 400) |

## Tested on

- Chrome 29 on OSX
- Chrome 28 on Windows
- Firefox 23 on OSX
- Firefox 21 on Windows
- Internet Explorer 7-10 on Windows
- Opera 16 on OSX
- Safari 6 on OSX
- Safari 6 on iPhone4/iOS6
- Safari 6 on iPhone5/iOS6
- Safari 6 on iPad2/iOS6
- Safari 6 on iPad3/iOS6