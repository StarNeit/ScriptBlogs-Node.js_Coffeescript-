zerorpc = require("zerorpc")
client = new zerorpc.Client()
client.connect("tcp://127.0.0.1:4242")