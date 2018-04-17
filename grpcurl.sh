
grpcurl -insecure=true -protoset .helloworld.Greeter.pbin localhost:2080 list helloworld.Greeter

grpcurl -insecure=true -protoset .helloworld.Greeter.pbin localhost:2080 describe helloworld.Greeter

grpcurl -insecure=true -d '{"name":"ngrpc"}' -protoset .helloworld.Greeter.pbin localhost:2080 helloworld.Greeter/SayHello

grpcurl -insecure=true -d '{"name":"ngrpc"}' -H 'cookie:customer=abcdefg,admin_customer=1234567' -H 'region:CH' -protoset .helloworld.Greeter.pbin localhost:2080 helloworld.Greeter/SayHello

echo '{"name":"tgrpc-prototool"}' | prototool -H 'cookie:customer=abcdefg,admin_customer=1234567;region:CH' grpc helloworld 0.0.0.0:2080 helloworld.Greeter/SayHello -



grpcurl -insecure=true -d '{"name":"ngrpc"}' localhost:2080 helloworld.Greeter/SayHello
