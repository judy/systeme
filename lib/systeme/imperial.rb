require 'systeme/registration'

module Systeme

  module Imperial
    
    def self.included(caller)
      caller.send :include, Systeme::Imperial::Declarations
    end

    module Units
      IMPERIAL_MEASURES = Hash.new

      IMPERIAL_MEASURES['length'] = Hash.new
      IMPERIAL_MEASURES['length'][:si] = 0.3048
      IMPERIAL_MEASURES['length'][:units] = Array.new    
      IMPERIAL_MEASURES['length'][:units] << { :unit => "thou", :factor => (1.0/12000), :aliases => ["mil"] }
      IMPERIAL_MEASURES['length'][:units] << { :unit => "inch", :factor => (1.0/12), :aliases => ["in", "inches"] }
      IMPERIAL_MEASURES['length'][:units] << { :unit => "foot", :factor => 1, :aliases => ["feet", "ft"] }
      IMPERIAL_MEASURES['length'][:units] << { :unit => "yard", :factor => 3, :aliases => ["yd"] }
      IMPERIAL_MEASURES['length'][:units] << { :unit => "furlong", :factor => 660 }
      IMPERIAL_MEASURES['length'][:units] << { :unit => "mile", :factor => 5280, :aliases => ["mi"] }
      IMPERIAL_MEASURES['length'][:units] << { :unit => "league", :factor => 15840 }
      # maritime units
      IMPERIAL_MEASURES['length'][:units] << { :unit => "fathom", :factor => 6 }
      IMPERIAL_MEASURES['length'][:units] << { :unit => "cable", :factor => 608 }
      IMPERIAL_MEASURES['length'][:units] << { :unit => "nautical_mile", :factor => 6080, :aliases => ["NM", "nmi", "M"] }
      IMPERIAL_MEASURES['length'][:units] << { :unit => "link", :factor => (66/100), :aliases => ["lnk"] }
      IMPERIAL_MEASURES['length'][:units] << { :unit => "rod", :factor => (66/4), :aliases => ["perch", "perches", "pole", "lug"] }
      IMPERIAL_MEASURES['length'][:units] << { :unit => "chain", :factor => 66 }      
    end # Units
    
    module Declarations
      Systeme::Imperial::Units::IMPERIAL_MEASURES.each do |measure, data|
        data[:units].each do |unit|
          define_method(unit[:unit].to_sym) { self * unit[:factor].to_f * data[:si] }
          class_eval("alias :" + unit[:unit] + "s :" + unit[:unit])
          Systeme::Registration::names << unit[:unit] << unit[:unit]+"s"
          if unit[:aliases]
            unit[:aliases].each do |aka|
               class_eval("alias :" + aka + " :" + unit[:unit])
               Systeme::Registration::names << aka
             end
          end
        end
      end
    end # Declarations

  end # Imperial

end