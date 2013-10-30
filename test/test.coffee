
expect = chai.expect

mocha.setup 'bdd'

request

setup = -> request = sinon.useFakeXMLHttpRequest()
teardown = -> request.restore()


describe 'uxhr', ->

	it 'should send the request to the passed URL', ->

		url = 'http://foobar.baz'

		sinon.useFakeXMLHttpRequest().onCreate = (xhr) ->
			uxhr url
			expect(xhr.url).to.deep.equal(url)

	it 'should set headers to those passed in options.headers', ->

		headers =
			'Content-Type': 'application/json'

		sinon.useFakeXMLHttpRequest().onCreate = (xhr) ->
			uxhr '#', {},
				headers: headers

			expect(xhr.headers).to.deep.equal(headers)

	it 'should set the timeout to that passed in options.timeout', ->

		timeout = 42

		sinon.useFakeXMLHttpRequest().onCreate = (xhr) ->
			uxhr '#', {},
				timeout: timeout

			expect(xhr.timeout).to.equal(timeout)

	describe 'data', ->

		it 'should encode data objects', ->

			data =
				foo: 'bar'
				baz: 'moo'

			sinon.useFakeXMLHttpRequest().onCreate = (xhr) ->

				console.log 'called'

				uxhr '#', data

				console.log 'xhr', xhr

				expect(true).to.equal(false)

	describe 'methods', ->

		it 'should default the method to GET', ->

			sinon.useFakeXMLHttpRequest().onCreate = (xhr) ->
				uxhr '#'
				expect(xhr.method).to.equal('GET')

		it 'should set the method to options.method', ->

			sinon.useFakeXMLHttpRequest().onCreate = (xhr) ->
				uxhr '#', {},
					method: 'POST'
				expect(xhr.method).to.equal('POST')

	describe 'callbacks', ->

		it 'should call options.complete()', ->

			complete = sinon.spy()
			server = sinon.fakeServer.create()
			
			uxhr '#', {},
				complete: complete

			server.requests[0].respond 200
			expect(complete.calledOnce).to.equal(true)

		it 'should call options.success()', ->

			success = sinon.spy()
			server = sinon.fakeServer.create()
			
			uxhr '#', {},
				success: success

			server.requests[0].respond 200
			expect(success.calledOnce).to.equal(true)

		it 'should call options.error()', ->

			error = sinon.spy()
			server = sinon.fakeServer.create()
			
			uxhr '#', {},
				error: error

			server.requests[0].respond 400
			expect(error.calledOnce).to.equal(true)

mocha.run()