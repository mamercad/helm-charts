.PHONY: ara-status ara-check ara-deploy ara-package ara-index ara-destroy \
				repo-update repo-add repo-search

.DEFAULT_GOAL := ara-check

ara-status:
	helm status ara

ara-check:
	helm install --dry-run --debug --create-namespace ara --namespace ara ./charts/ara

ara-deploy: ara-check
	helm install --create-namespace ara --namespace ara ara ./charts/ara

ara-package:
	helm package ./charts/ara --destination ./charts

ara-index:
	helm repo index ./charts/ara

ara-destroy: ara-status
	helm uninstall ara

repo-update:
	helm repo update

repo-add:
	helm repo add mamercad https://mamercad.github.io/helm-charts

repo-search:
	helm search repo ara

# cloudmason.org is my (home) domain, i think i needed `env.ARA_ALLOWED_HOSTS` because TLS was offloaded to my edge
helm-install:
	helm install ara mamercad/ara --create-namespace --namespace ara --set env.ARA_ALLOWED_HOSTS="['ara.cloudmason.org']"

helm-upgrade:
	helm upgrade ara mamercad/ara

helm-uninstall:
	helm uninstall ara
