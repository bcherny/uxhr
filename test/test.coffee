
expect = chai.expect

mocha.setup 'bdd'

describe 'uxhr', ->

	it 'should default the XMLHttpRequest method to GET', ->

		xhr = sinon.useFakeXMLHttpRequest()

		xhr.onCreate = (xhr) ->
			uxhr '#', {}
			expect(xhr.method).to.equal('GET')

	it 'should set the XMLHttpRequest method to options.method', ->

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