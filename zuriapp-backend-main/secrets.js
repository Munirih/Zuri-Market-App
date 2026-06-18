const {
  SecretsManagerClient,
  GetSecretValueCommand,
} = require("@aws-sdk/client-secrets-manager");

async function loadSecrets() {
  const secretName = process.env.AWS_SECRET_NAME;
  if (!secretName) {
    return {
      API_SECRET_KEY: process.env.API_SECRET_KEY,
      STORE_NAME: process.env.STORE_NAME || "My Store",
    };
  }
  const client = new SecretsManagerClient({
    region: "us-east-1",
  });

  const response = await client.send(
    new GetSecretValueCommand({
      SecretId: secretName,
    })
  );

  return JSON.parse(response.SecretString);
}

module.exports = { loadSecrets };