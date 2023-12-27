require 'rails_helper'

RSpec.describe SpreadsController, type: :controller do
  describe 'GET market' do
    it 'calculates the spread for a given market' do
      # Aquí escribes tu prueba para el endpoint de mercado específico
    end

    it 'handles cases where there is no data' do
      # Prueba para manejar casos donde no hay datos suficientes
    end
  end

  describe 'GET all_markets' do
    it 'calculates spreads for all markets' do
      # Prueba para verificar que se obtienen los spreads de todos los mercados
    end
  end

  # Más pruebas para set_alert_spread y alert_spread
end
