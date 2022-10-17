base:
  '*':
    - initial_setup
    - main_jobs
  'k3s-prod-master01':
    - k3s.install_k3smaster
    - workshop.install_kubetools
  'k3s-prod-worker*':
    - k3s.install_k3sworker
  '*workshop*':
    - workshop.install_kubetools
    - workshop.install_terraformtools
