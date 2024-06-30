# README

gh repo clone amartini93/lemontech
cd lemontech

sudo docker-compose build
sudo docker-compose up

(Could be needed. Test without first)
sudo docker-compose run web bundle exec rails db:create
sudo docker-compose run web bundle exec rails db:migrate
sudo docker-compose run web bundle exec rails db:seed

Test the ap at:
http://localhost:3000

Play with logging and registration.
Play with Event creation and invitations (only even creators should be able to edit and delete events)
Play with profile edition
That should cover the CRUD and all the other requirements for the test
