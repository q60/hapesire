defmodule Hapesire.Quotations do
  use Ash.Domain

  resources do
    resource Hapesire.Quotations.Quote
  end
end
