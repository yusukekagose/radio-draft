namespace :scraping do

  task scrape_station: :environment do

    url = "https://radioinfo.radiko.jp/?action=station-list"

    agent = Mechanize.new
    page = agent.get(url)
    elements = page.search('div.st_area_name a')



    elements.each do |ele|
      station_name = ele.inner_text

      station_url = ele.get_attribute(:href)

      station = Station.new(name: station_name, url: station_url)
      if station.save
        puts station_name + " " + station_url
      end

    end
  end
end
