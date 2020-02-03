class MerchantRevenueSerializer
    include FastJsonapi::ObjectSerializer

    attributes :revenue do |x|
        '%.2f' % (x.revenue / 100)
    end
end