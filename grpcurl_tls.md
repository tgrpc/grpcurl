
1 . 使用 cmux 暴露了50051端口，同时提供 http grpc接口。

grpcurl localhost:50051 helloworld.Greeter/SayHello

```
Failed to dial target host "localhost:50051": tls: oversized record received with length 20527
```

走了http协议


2 . 使用 nginx 代理grpc

grpcurl localhost:80 list helloworld.Greeter/SayHello

```
Failed to dial target host "localhost:80": tls: first record does not look like a TLS handshake
```

3. 纯 grpc端口

grpcurl localhost:50051 helloworld.Greeter/SayHello

```
Failed to dial target host "localhost:50051": tls: first record does not look like a TLS handshake
```

4. nginx 代理 纯grpc端口

grpcurl localhost:80 helloworld.Greeter/SayHello


```
Failed to dial target host "localhost:80": tls: first record does not look like a TLS handshake
```

看来是grpc接口问题，tls

ClientTransportCredentials 没有设置tls，返回 nil,nil

```
Error invoking method "helloworld.Greeter/SayHello": failed to query for service descriptor "helloworld.Greeter": rpc error: code = Internal desc = transport: received the unexpected content-type "text/html"
```

需要protoset

```
protoc --proto_path=. \
    --descriptor_set_out=.helloworld.Greeter.pbin \
    --include_imports \
    helloworld/helloworld.proto
```

grpcurl -d '{"name":"ngrpc"}' -protoset .helloworld.Greeter.pbin localhost:80 helloworld.Greeter/SayHello

