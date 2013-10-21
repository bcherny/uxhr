
expect = chai.expect

mocha.setup 'bdd'

describe 'uxhr', ->

	it 'should set headers to those passed in options.headers', ->

		headers =
			'Content-Type': 'application/json'

		sinon.useFakeXMLHttpRequest().onCreate = (xhr) ->
			uxhr '#', {},
				headers: headers

			expect(xhr.headers).to.deep.equal(headers)

	describe 'methods', ->

		it 'should default the method to GET', ->

			xhr = sinon.useFakeXMLHttpRequest()

			xhr.onCreate = (xhr) ->
				uxhr '#', {}
				expect(xhr.method).to.equal('GET')

		it 'should set the method to options.method', ->

			xhr = sinon.useFakeXMLHttpRequest()

			xhr.onCreate = (xhr) ->
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