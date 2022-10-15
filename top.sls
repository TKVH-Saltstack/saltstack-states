base:
  '*':
    - initial_setup
  'k3s*master01':
    - k3s.install_k3smaster
