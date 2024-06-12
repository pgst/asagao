class Article < ApplicationRecord
  validates :title, :body, :released_at, presence: true
  validates :title, length: { maximum: 80 }
  validates :body, length: { maximum: 2000 }

  def no_expiration
    expired_at.nil?
  end

  def no_expiration=(val)
    @no_expiration = val.in?([true, '1'])
  end

  before_validation do
    self.expired_at = nil if @no_expiration
  end

  # validateはブロックを取ることができる
  validate do
    # 掲載終了日時が設定されていて、かつそれが掲載開始日時よりも古い場合、
    # エラーオブジェクトのaddメソッドを呼び出して、バリデーションエラーを追加
    if expired_at && expired_at < released_at
      # 第1引数には属性名のシンボル、第2引数にはエラーの種類を示すシンボルを指定
      errors.add(:expired_at, :expired_at_too_old)
    end
  end

  scope :open_to_the_public, -> { where(member_only: false) }

  scope :visible, -> do
    now = Time.current

    where("released_at <= ?", now)
      .where("expired_at > ? OR expired_at IS NULL", now)
  end
end
