defmodule BankLambdaWeb.Api.V1.PaymentController do
  use BankLambdaWeb, :controller

  alias BankLambda.Accounts.User

  # parameters:
  # debtorAccount: %{iban: acct.iban},
  # creditorAccount: %{iban: params["merchant_iban"]},
  # instructedAmount: %{currency: "EUR", amount: params["amount"]},
  # creditorName: params["merchant_name"],
  # endToEndIdentification: params["bc_tx_id"],
  # remittanceInformationUnstructured: params["merchant_tx_id"]

  def payment(conn, params) do
    # - ACCC AcceptedSettlementCompleted Settlement on the creditor's account has been completed.
    # - ACCP AcceptedCustomerProfile Preceding check of technical validation was successful. Customer profile check was also successful.
    # - ACSC AcceptedSettlementCompleted Settlement on the debtors account has been completed.
    # - ACSP AcceptedSettlementInProcess All preceding checks such as technical validation and customer profile were successful and therefore the payment initiation has been accepted for execution.
    # ...

    # [consent_id] = get_header(conn, "x-consent-id")
    # usr = User.find_by_access_token(consent_id)
    # acct = BankAccount.find_by_user(usr, get_in(params, ["debtorAccount", "iban"])
    # amt = get_in(params, ["instructedAmount", "amount"])
    # pmt_id = UUID.uuid4
    # Processor.payment(acct, amt, merchant_iban)

    pmt_id = "pmt_#{:crypto.rand_uniform(100_000, 1_000_000)}"

    conn
    |> put_status(201)
    |> json(%{
      # For now lets' return immediately that it settled successfully
      # in reality this will take a few seconds.
      transactionStatus: "ACCC",
      paymentId: pmt_id,
      transactionFeeIndicator: false,
      _links:
        %{
          # ...
        }
    })
  end
end
