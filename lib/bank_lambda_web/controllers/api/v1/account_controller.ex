defmodule BankLambdaWeb.Api.V1.AccountController do
  use BankLambdaWeb, :controller

  def index(conn, params) do
    # TODO: implement
    # acct = find_account(conn)
    conn
    |> put_status(200)
    |> json(%{
      accounts: [
        %{
          resourceId: "string",
          iban: "DE94500105173474442764",
          bban: "BARC12345612345678",
          msisdn: "+49 170 1234567",
          currency: "EUR",
          name: "Checking Account",
          product: "string",
          cashAccountType: "string",
          status: "enabled",
          bic: "AAAADEBBXXX",
          linkedAccounts: "string",
          usage: "PRIV",
          details: "string",
          balances: [
            %{
              balanceAmount: %{
                currency: "EUR",
                amount: "1001"
              },
              balanceType: "closingBooked",
              creditLimitIncluded: false,
              # lastChangeDateTime: "2019-05-07T07:17:45.052Z",
              # referenceDate: "2019-05-07",
              lastCommittedTransaction: "string"
            }
          ],
          _links: %{
            balances: %{
              href: "/v1/payments/sepa-credit-transfers/1234-wertiq-983"
            },
            transactions: %{
              href: "/v1/payments/sepa-credit-transfers/1234-wertiq-983"
            },
            additionalProp1: %{
              href: "/v1/payments/sepa-credit-transfers/1234-wertiq-983"
            },
            additionalProp2: %{
              href: "/v1/payments/sepa-credit-transfers/1234-wertiq-983"
            },
            additionalProp3: %{
              href: "/v1/payments/sepa-credit-transfers/1234-wertiq-983"
            }
          }
        }
      ]
    })
  end
end
