base:

  '*':
    - states_default.initial_setup
    - states_default.main_jobs

  'k3s*master01':
    - states_k3s.install_k3smaster
    - states_workshop.install_kubetools

  'k3s*worker*':
    - states_k3s.install_k3sworker

  '*workshop*':
    - states_workshop.install_kubetools
    - states_workshop.install_terraformtools
