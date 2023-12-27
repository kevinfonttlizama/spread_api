require 'httparty'

class SpreadsController < ApplicationController
  @@alert_spread = nil
  
  private

  def make_api_request(url)
    response = HTTParty.get(url)
    return response if response.success?
  
  rescue StandardError => e
    puts "Exception: #{e.message}"
    nil
  end
  
  


  def market
    market_id = params[:market_id]
    spread = calculate_spread_for_market(market_id)
    render json: { market: market_id, spread: spread }
  end

  def all_markets
    markets = get_all_markets_from_buda
    spreads = markets.map do |market|
      { market: market, spread: calculate_spread_for_market(market) }
    end
    render json: { spreads: spreads }
  end

  def set_alert_spread
    alert_spread = AlertSpread.first_or_create
    alert_spread.update(value: params[:spread].to_f)
    render json: { alert_spread: alert_spread.value }
  end

  def alert_spread
    alert_spread = AlertSpread.first
    render json: { alert_spread: alert_spread&.value || 'No establecido' }
  end
  
  private
  
  def get_all_markets_from_buda
    url = 'https://www.buda.com/api/v2/markets.json'
    response = HTTParty.get(url)
    return [] unless response.success?
  
    response.parsed_response['markets'].map { |market| market['id'] }
  end
  

  
  private

  def calculate_spread_for_market(market_id)
    url = "https://www.buda.com/api/v2/markets/#{market_id}/order_book.json"
    response = HTTParty.get(url)
  
    if response.success?
      order_book = response.parsed_response['order_book']
      best_bid = order_book['bids'].first&.first&.to_f
      best_ask = order_book['asks'].first&.first&.to_f
      if best_bid && best_ask
        spread = best_ask - best_bid
      else
        puts "Mercado #{market_id}: No hay suficientes datos para calcular el spread."
        spread = 'Datos insuficientes'
      end
    else
      puts "Error al conectarse a la API: #{response.code}"
      spread = 'Error en la conexión'
    end
  
    spread
  end

end 
  
