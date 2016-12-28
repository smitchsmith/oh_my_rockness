require 'time'
require 'mechanize'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

Capybara.default_driver = :poltergeist

module OhMyRockness
  URL = "http://ohmyrockness.com/shows/just-announced?all=true"

  class Index
    attr_reader :url

    def initialize(url = URL)
      @url = url
    end

    def scrape
      rows.map { |row| Row.new(row).to_h }
    end

    private

    def rows
      browser.all("#shows .row")
    end

    def browser
      @browser ||= Capybara.current_session.tap { |b| b.visit(url) }
    end
  end

  class Row < Struct.new(:row)
    def to_h
      {
        date:    date,
        artists: artists,
        venue:   venue,
        cost:    cost
      }
    end

    private

    def date
      row.find(".date .value-title")[:title]
    end

    def artists
      row.all(".bands a").map(&:text)
    end

    def venue
      {
        name: venue_tag.text,
        link: venue_tag[:href].to_s
      }
    end

    def venue_tag
      @venue_tag ||= row.find(".venue a.location")
    end

    def cost
      if row.first(".tickets .free-show")
        "Free"
      elsif (cost = row.first(".tickets .price"))
        cost.text
      end
    end
  end
end
