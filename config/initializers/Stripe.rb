Rails.configuration.stripe = {
  publishable_key: "pk_test_51OreMASJqfkZjluecHkV6ag0L0Vvh9J937DnvKls1av8Zs83CrFuNJjCFDqL0xRwZS2Sfia8DpGBP7wDYkPlP1Hs00dcX9fnnE",
  secret_key: "sk_test_51OreMASJqfkZjlueuScOYh5yhz4G6pYjo3Co0LnsRSn8jBnB1FWdOqRumCYDlFzXHRU8w7ajQNG4iMvs9vab27PA00mRAWyfgJ"
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]    
