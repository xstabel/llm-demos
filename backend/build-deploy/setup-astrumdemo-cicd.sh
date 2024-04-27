export PROJECT_ID=$(gcloud config get-value project)
export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format='value(projectNumber)')
export PROJECT_NAME=$(gcloud projects describe $PROJECT_ID --format='value(name)')
export REGION=us-central1
export IMAGE_NAME=inventory-api
export REPO_NAME=cymbal-superstore

# Create and Deploy front-end service.

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com \
    --role=roles/clouddeploy.operator

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com \
    --role=roles/iam.serviceAccountUser

gcloud builds submit \
  --config cloudbuild.yaml \
  --substitutions=_REGION=${REGION},_IMAGE_NAME=${IMAGE_NAME},_REPO_NAME=${REPO_NAME}



