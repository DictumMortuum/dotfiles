test -d "$HOME/.composer/vendor/bin" && PATH="$HOME/.composer/vendor/bin:$PATH"

DRUPAL="/home/openbet/Code/drupal"

drushmake() {
  drush make \
    $DRUPAL/make-sportsbook-pmu_sportsbook/pmu_sportsbook.make \
    $DRUPAL/$1 \
    --working-copy --no-gitinfofile --prepare-install --contrib-destination=profiles/core -y OxiBet
}

pmudsi_ra5() {
  cd  $DRUPAL/$1
  php scripts/obet-pre-install.php
  drush si \
    --account-pass=admin \
    --clean-url=1 \
    --db-url=mysql://root:root@localhost/$1 \
    core -y \
    --uri="http://localhost/$1" \
    --site-name="PMU SportsBook" \
    config_module_configure_form.config_module=pmu_deploy \
    drupal_caching_configure_form.drupal_cache_implementation=memcache \
    currency_configure_form.currency_options="EUR" \
    endpoint_configure_form.openbet_api_trusted_token="17" \
    endpoint_configure_form.openbet_api_password="SiteBuilder1" \
    endpoint_configure_form.openbet_api_username="Sitebuilder" \
    sdk_database_config_form.db_password="root" \
    endpoint_configure_form.siteserver_url="http://dev01.openbet/pmu/ra5/ss/" \
    endpoint_configure_form.openbet_api_url="http://dev01.openbet/pmu/ra5/oxi" \
    module_suite_configure_form.enable_openbet_account sportsbook_config_lang_config_form.default_lang='fr-ob' \
    endpoint_configure_form.siteserver_version='2_16' \
    endpoint_configure_form.openbet_api_trusted_username="Sitebuilder_2" \
    endpoint_configure_form.openbet_api_trusted_password="SiteBuilder1"
  php scripts/obet-post-install.php
  drush en pmu_tuning -y
  drush en devel -y
  drush vset dev_mem 1
  drush vset dev_timer 1
  drush vset pmu_event_list_caching_ttl 600
  drush vset obet_hierarchy_menu_tree_cache_time 600
  drush vset pmu_connect_cookies_domain "localhost"
  drush vset eu_compliance_cookie_domain "localhost"
  drush vset pmu_connect_url_client "http://localhost/pmuconnect/auth/client/2/"
  drush vset pmu_connect_url_server "http://localhost/pmuconnect/auth/client/2/"
  drush vset pmu_connect_url_flush_balance "http://localhost/pmuconnect/account/client/2/caisse/solde/invalider"

  php -r "print json_encode(array(
    'autolimitations_default_value' => 99999900,
    'autolimitations_url' => 'http://localhost/pmuconnect/account/client/2/autolimitations/sports',
    'timeout' => '1000',
    'change_weekly_bet_limit_url' => 'https://recette.pmu.fr/compte/autolimitations?clientApi=2&typeCompte=2010&redirectionUrl=https%3A%2F%2Fparis-sportifs-recette.pmu.fr%2F'
  ));" | drush vset --format=json pmu_connect_autolimitations -

  php -r "print json_encode(array(
    'messages_url' => 'http://localhost/pmuconnect/account/client/2/messages',
    'confirm_url' => 'http://localhost/pmuconnect/account/client/2/messages/acquitter',
    'timeout' => '1000'
  ));" | drush vset --format=json pmu_messages_configuration -

  php -r "print json_encode(array(
    'request_url' => 'http://localhost/pmuconnect/account/client/2/marketing/interactif/offres?emplacement=<emplacement>',
    'track_url' => 'http://localhost/pmuconnect/account/client/2/marketing/interactif/offres?emplacement=<emplacement>&propositionId=<propositionId>',
    'request_timeout' => '1000',
    'ads_blocks' => 'SPORT'
  ));" | drush vset --format=json pmu_neolane_ads_configuration -
}

pmudsi_ra1() {
  cd  ~/projects/SiteBuilder/$1
  php scripts/obet-pre-install.php
  drush si --account-pass=admin --clean-url=1 --db-url=mysql://root:root@localhost/$1 core -y --uri="http://localhost/$1" --site-name="PMU SportsBook" config_module_configure_form.config_module=pmu_deploy drupal_caching_configure_form.drupal_cache_implementation=memcache currency_configure_form.currency_options="EUR" endpoint_configure_form.openbet_api_trusted_token="17" endpoint_configure_form.openbet_api_password="SiteBuilder1" endpoint_configure_form.openbet_api_username="Sitebuilder" sdk_database_config_form.db_password="root" endpoint_configure_form.siteserver_url="http://dev01.openbet/pmu/ra1/ss/" endpoint_configure_form.openbet_api_url="http://dev01.openbet/pmu/ra1/oxi" module_suite_configure_form.enable_openbet_account sportsbook_config_lang_config_form.default_lang='fr-ob' endpoint_configure_form.siteserver_version='2_16' endpoint_configure_form.openbet_api_trusted_username="Sitebuilder_2" endpoint_configure_form.openbet_api_trusted_password="SiteBuilder1"
  php scripts/obet-post-install.php
  drush en pmu_tuning -y
  drush en devel -y
  drush vset dev_mem 1
  drush vset dev_timer 1
  drush vset pmu_event_list_caching_ttl 600
  drush vset obet_hierarchy_menu_tree_cache_time 600
  drush vset pmu_connect_cookies_domain "localhost"
  drush vset eu_compliance_cookie_domain "localhost"
  drush vset pmu_connect_url_client "http://localhost/pmuconnect/auth/client/2/"
  drush vset pmu_connect_url_server "http://localhost/pmuconnect/auth/client/2/"
  drush vset pmu_connect_url_flush_balance "http://localhost/pmuconnect/account/client/2/caisse/solde/invalider"

  php -r "print json_encode(array(
    'autolimitations_default_value' => 99999900,
    'autolimitations_url' => 'http://localhost/pmuconnect/account/client/2/autolimitations/sports',
    'timeout' => '1000',
    'change_weekly_bet_limit_url' => 'https://recette.pmu.fr/compte/autolimitations?clientApi=2&typeCompte=2010&redirectionUrl=https%3A%2F%2Fparis-sportifs-recette.pmu.fr%2F'
  ));" | drush vset --format=json pmu_connect_autolimitations -

  php -r "print json_encode(array(
    'messages_url' => 'http://localhost/pmuconnect/account/client/2/messages',
    'confirm_url' => 'http://localhost/pmuconnect/account/client/2/messages/acquitter',
    'timeout' => '1000'
  ));" | drush vset --format=json pmu_messages_configuration -

  php -r "print json_encode(array(
    'request_url' => 'http://localhost/pmuconnect/account/client/2/marketing/interactif/offres?emplacement=<emplacement>',
    'track_url' => 'http://localhost/pmuconnect/account/client/2/marketing/interactif/offres?emplacement=<emplacement>&propositionId=<propositionId>',
    'request_timeout' => '1000',
    'ads_blocks' => 'SPORT'
  ));" | drush vset --format=json pmu_neolane_ads_configuration -
}
