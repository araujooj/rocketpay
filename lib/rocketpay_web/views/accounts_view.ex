defmodule RocketpayWeb.AccountsView do
  alias Rocketpay.Account
  alias Rocketpay.Account.Transaction.Response, as: TransactionResponse

  def render("update.json", %{
        account: %Account{id: account_id, balance: balance}
      }) do
    %{
      account: %{
        id: account_id,
        balance: balance
      }
    }
  end

  def render("transaction.json", %{
        transaction: %TransactionResponse{
          from_account: %{id: from_account_id, balance: from_account_balance},
          to_account: %{id: to_account_id, balance: to_account_balance}
        }
      }) do
    %{
      message: "Transaction done sucessfully",
      transaction: %{
        from_account: %{
          id: from_account_id,
          balance: from_account_balance
        },
        to_account: %{
          id: to_account_id,
          balance: to_account_balance
        }
      }
    }
  end
end
