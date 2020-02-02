class MerchantRevenueSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :name

    attributes :revenue do |x|
        '%.2f' % (x.revenue / 100)
    end
end