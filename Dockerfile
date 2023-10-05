FROM ruby:3.1.4

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		sqlite3 \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app



RUN git clone https://github.com/sumukhprasad/blockjam .
RUN rm config/credentials.yml.enc
RUN bundle install
RUN EDITOR=echo rails credentials:edit

RUN RAILS_ENV=production rails db:create db:migrate db:seed
RUN RAILS_ENV=production rails assets:precompile
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0", "-e", "production"]