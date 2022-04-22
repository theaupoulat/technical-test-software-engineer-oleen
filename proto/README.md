# Proto

## Vocabulaire

- _Protobuf_: Protocal Buffers est un format de sérialisation via un langage de description d'interface.
- _GRPC_: gRPC Remote Procedure Call est un framework RPC basé sur HTTP/2 (transport) et Protobuf (Langage).
- _GRPC-Web-Ruby_: Implémentation GRPC serveur compatible HTTP/1. Voir https://github.com/Gusto/grpc-web-ruby
- _Buf_: Plateforme de développement schema-driven. Voir https://docs.buf.build/

## Installation

```
$ docker build . -t buf
```

## Utilisation

### Linter

Vérification des définition de types configurées dans `buf.yaml`

```shell
$ docker run -v $PWD:/tmp -it buf lint
```

### Codegen

Génération des librairies client / serveurs décrites dans le fichier proto, suivant la configuration du `buf.gen.yaml`:

- Ruby
- JavaScript et TypeScript
- Documentation HTML et Markdown

```shell
# Macos
$ docker run -v $PWD:/tmp -it buf generate
```
