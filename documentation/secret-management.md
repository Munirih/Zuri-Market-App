# Secret Management

## Local Development

During local development, secrets are stored in a `.env` files that is not committed to source control.


```
Backend env
```env
API_SECRET_KEY=your-api-key
STORE_NAME=your_store_name
```

The application loads these values using `dotenv`:

```javascript
require("dotenv").config();
```

This allows developers to run the application locally without accessing cloud resources.

---

## CI/CD Pipeline (GitHub Actions)

During CI/CD execution, sensitive values are stored in GitHub Actions Secrets.

Examples include:

- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- AWS_REGION
- AWS_SSH_KEY_NAME
- AWS_EC2_SSH_KEY
- EC2_USER
- DOCKERHUB_USERNAME
- DOCKERHUB_TOKEN

These secrets are injected into workflow jobs at runtime and are never committed to the repository.

Example:

```yaml
env:
  TF_VAR_ec2_key_name: ${{ secrets.AWS_SSH_KEY_NAME }}
```

GitHub Actions secrets are used primarily for:

- Terraform authentication to AWS
- Docker Hub authentication
- Infrastructure provisioning
- Application deployment


---

## Production Environment (AWS Secrets Manager)

In production, application secrets are stored in AWS Secrets Manager.

Application-level secrets such as `API_SECRET_KEY` and `STORE_NAME` are not passed through GitHub Actions.

Example secret:

```json
{
  "API_SECRET_KEY": "api-key",
  "STORE_NAME": "Zuri Store"
}
```

The backend application retrieves secrets at runtime using the AWS SDK. Authentication is performed through an IAM Role attached to the EC2 instance via an Instance Profile.


This approach eliminates the need to:

- Store secrets in GitHub Actions
- Store secrets in Kubernetes manifests
- Store secrets in Docker images
- Commit secrets to source control

