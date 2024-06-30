import { LightningElement, track } from "lwc";
import searchStockdata from "@salesforce/apex/FinanceDataCallout.searchStockdata";

const columns = [
  { label: "Stock Name", fieldName: "name" },
  { label: "Stock Exchange", fieldName: "exchange" },
  { label: "Today Stock Price", fieldName: "price" },
  { label: "Previous Stock Price", fieldName: "previous_close" },
  { label: "Change", fieldName: "change" },
  { label: "Percent change (in %)", fieldName: "change_percent" }
];

export default class StockData extends LightningElement {
  columns = columns;
  @track display = false;
  @track stockDisplay = [];
  stock = "";
  stockInfo = "";

  handleInputChange(event) {
    this.stock = event.target.value;
  }

  handleStockInfo() {
    searchStockdata({ stockName: this.stock })
      .then((result) => {
        console.log("Data reveived: ", result);
        this.stockInfo = result;
        this.display = true;
        this.stockInfo = JSON.parse(result);
        this.stockArray = this.stockInfo.data.stock;
        for (let i = 0; i < this.stockArray.length; i++) {
          const stock = this.stockArray[i];
          const firstStockSymbol = stock.symbol;
          const firstStockName = stock.name;
          const firstStockPrice = stock.price;
          const firstStockPricechange = stock.change;
          const firstStockPricechangepercent = stock.change_percent;
          const firstStockPricepreviousclose = stock.previous_close;
          const exchange = stock.exchange;

          const formattedStockObj = {
            id: i,
            symbol: firstStockSymbol,
            name: firstStockName,
            price: firstStockPrice,
            change: firstStockPricechange,
            change_percent: firstStockPricechangepercent,
            previous_close: firstStockPricepreviousclose,
            exchange: exchange
          };

          this.stockDisplay.push(formattedStockObj);
        }
      })
      .catch((error) => {
        console.log("Error Occured: ", error);
      });
  }

  handleReset() {
    this.display = false;
    this.stock = "";
    this.stockInfo = "";
    this.stockDisplay = [];
    this.template.querySelector("form").reset();
  }
}
