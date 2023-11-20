import os
import time

import grpc.experimental

protos, services = grpc.protos_and_services("helloworld.proto")

name = "Lorem"
message = "Ping!"

endpoint = os.environ["ENDPOINT"]

if __name__ == "__main__":
    request = protos.HelloRequest(name=name, message=message)
    while True:
        if 'USE_TLS' in os.environ and os.environ["USE_TLS"] == "true":
            response = services.Greeter.SayHello(request, endpoint, insecure=False)
        else:
            response = services.Greeter.SayHello(request, endpoint, insecure=True)

        print("Sent '{}' as '{}' to '{}'".format(message, name, endpoint))
        print("Received '{}', from '{}' from '{}'".format(response.message, response.name, endpoint))
        print()

        time.sleep(1)
