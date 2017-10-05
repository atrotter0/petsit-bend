module TestimonialsHelper
  def no_approved_testimonials?
    none_approved = true
    return if @testimonials.blank?
    @testimonials.each do |testimonial|
      none_approved = false if testimonial.approved == true
    end
    none_approved
  end
end
