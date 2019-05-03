def cond(v1):
  if v1:
    apiVersion: apps/v1
    kind: Deployment
  else:
    apiVersion: extensions/v1beta1
    kind: Deployment

cond(True)
