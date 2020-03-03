h1 Verify via Authy

- if user
  - if user.errors
    ul.errors
    - user.errors.each do |error|
      li = error.to_s
      
form action="/verify" method="post"
  == csrf_tag
  .form-group
    input.form-control type="text" name="authy_token" placeholder="Authy Token"
  button.btn.btn-success.btn-sm type="submit"
    | Verify
