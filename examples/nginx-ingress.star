# example is based on the following post: https://bit.ly/2QNCWab
# we start by creating a simple pod+service configuration.

def labels():
  app: apple

def apple(data):
  kind: Pod
  apiVersion: v1
  metadata:
    name: apple-app
    labels: s{ labels() }
  spec:
    containers:
    - name: apple-app
      image: hashicorp/http-echo
      args:
      - -text={ data.text }

def service(data):
  kind: Service
  apiVersion: v1
  metadata:
    name: apple-service
  spec:
    selector: labels()
    ports:
    - port: { data.port }

def data():
  port: "8080"
  #! note how text is quoted automatically in the result file
  text: "Hello #ytt World!"

d= data()
print([apple(d), service(d)])