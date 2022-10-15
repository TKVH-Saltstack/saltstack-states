base:
  '*':
    - initial_setup
  'k3s-prod-master01':
    - k3s.install_k3smaster
  'k3s-prod-worker*':
    - k3s.install_k3sworker
