import os
import threading
from concurrent import futures

import grpc
import grpc.experimental
from grpc_reflection.v1alpha import reflection

protos, services = grpc.protos_and_services("helloworld.proto")


class Greeter(services.GreeterServicer):
    def __init__(self):
        self.name = "Ipsum"
        self.message = "Pong!"

    def SayHello(self, request, context):
        print("Received '{}' from '{}'".format(request.message, request.name)),
        print("Sent '{}' as '{}'".format(self.message, self.name))
        print()

        return protos.HelloReply(name=self.name, message=self.message)


if __name__ == "__main__":
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))

    greater = Greeter()

    services.add_GreeterServicer_to_server(greater, server)

    SERVICE_NAMES = (
        protos.DESCRIPTOR.services_by_name['Greeter'].full_name,
        reflection.SERVICE_NAME,
    )
    reflection.enable_server_reflection(SERVICE_NAMES, server)

    if 'LISTEN_PORT_TLS' in os.environ:
        server_port_tls = "0.0.0.0:{}".format(os.environ["LISTEN_PORT_TLS"])

        server_key_file = 'server.key.pem'
        server_cert_file = 'server.crt.pem'

        server_key = open(server_key_file).read()
        server_cert = open(server_cert_file).read()

        credentials = grpc.ssl_server_credentials([(
            bytes(server_key, "UTF-8"),
            bytes(server_cert, "UTF-8")
        )])

        server.add_secure_port(server_port_tls, credentials)

    server_port = "0.0.0.0:{}".format(os.environ["LISTEN_PORT"])
    server.add_insecure_port(server_port)

    server.start()
    server.wait_for_termination()
