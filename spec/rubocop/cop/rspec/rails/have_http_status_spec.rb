# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RSpec::Rails::HaveHttpStatus do
  it 'registers an offense for `expect(response.status).to be(200)`' do
    expect_offense(<<~RUBY)
      it { expect(response.status).to be(200) }
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Prefer `expect(response).to have_http_status(200)` over `expect(response.status).to be(200)`.
    RUBY

    expect_correction(<<~RUBY)
      it { expect(response).to have_http_status(200) }
    RUBY
  end

  it 'registers an offense for `expect(response.status).not_to eq(404)`' do
    expect_offense(<<~RUBY)
      it { expect(response.status).not_to eq(404) }
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Prefer `expect(response).not_to have_http_status(404)` over `expect(response.status).not_to eq(404)`.
    RUBY

    expect_correction(<<~RUBY)
      it { expect(response).not_to have_http_status(404) }
    RUBY
  end

  it 'registers an offense for `expect(response.code).to eq("200")`' do
    expect_offense(<<~RUBY)
      it { expect(response.code).to eq("200") }
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Prefer `expect(response).to have_http_status(200)` over `expect(response.code).to eq("200")`.
    RUBY

    expect_correction(<<~RUBY)
      it { expect(response).to have_http_status(200) }
    RUBY
  end

  it 'does not register an offense for `is_expected.to be(200)`' do
    expect_no_offenses(<<~RUBY)
      it { is_expected.to be(200) }
    RUBY
  end

  it 'does not register an offense for `expect(res.status).to be(200)`' do
    expect_no_offenses(<<~RUBY)
      it { expect(res.status).to be(200) }
    RUBY
  end

  it 'ignores statuses that would not coerce to an integer' do
    expect_no_offenses(<<~RUBY)
      it { expect(response.status).to eq("404 Not Found") }
    RUBY
  end
end
