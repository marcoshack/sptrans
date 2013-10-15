module Sptrans
  class Line < OpenStruct
    def self.find(name)
      Sptrans::Api.line(name).map do |line|
        Line.new(
          id:       line["CodigoLinha"],
          nro:      line["Letreiro"],
          type:     line["Tipo"],
          course:   line["Sentido"],
          labels:   [line["DenominacaoTPTS"], line["DenominacaoTSTP"]],
          info:     line["Informacoes"],
          circular?:line["Circular"]
        )
      end
    end

    def label
      if course == 1
        self.labels.first
      else
        self.labels.last
      end
    end
    alias_method :target, :label

    def code
      "#{self.nro}/#{self.type}"
    end

    def to_s
      str = "#{self.code} - #{self.target}"
      str += " (#{self.info}) " unless self.info.nil?
      return str
    end

  end
end
