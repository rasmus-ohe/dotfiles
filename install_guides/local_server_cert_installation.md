# Local server certification installation

## 1. Create cert

## 1.1 Install required packages

### Arch

`yay -Syu --noconfirm ca-certificates p11-kit`

## 2. Send a copy of cert to wanted device(s)

`sudo cp rootCA.pem /etc/ca-certificates/trust-source/mkcert-home-arpa.pem`

## 3. Update/rebuild the trust store

`sudo trust extract-compat`

## 4. Verify that the CA is trusted

`trust list | grep mkcert`

or test HTTPS directly:

`curl https://your-service.home.arpa`
