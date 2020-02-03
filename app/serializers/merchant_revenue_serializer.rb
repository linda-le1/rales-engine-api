class MerchantRevenueSerializer
    include FastJsonapi::ObjectSerializer

    attributes :total_revenue do |x|
        '%.2f' % (x.total_revenue / 100)
    end
end