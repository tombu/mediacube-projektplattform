# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
#  inflect.plural /^(ox)$/i, '\1en'
#  inflect.singular /^(ox)en/i, '\1'
#  inflect.uncountable %w( fish sheep )
  inflect.irregular 'Projekt', 'Projekte'
  inflect.irregular 'Job', 'Jobs'
  inflect.irregular 'Beobachter', 'Beobachter'
#  inflect.irregular 'Follower', 'Follower'
  inflect.irregular 'Mitglied', 'Mitglieder'
  inflect.irregular 'Ergebnis', 'Ergebnisse'
  
# Date Time
  inflect.irregular 'Sekunde', 'Sekunden'
  inflect.irregular 'Minute', 'Minuten'
  inflect.irregular 'Stunde', 'Stunden'
  inflect.irregular 'Tag', 'Tagen'
end
