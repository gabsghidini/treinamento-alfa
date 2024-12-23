const cds = require("@sap/cds");

class OrderService extends cds.ApplicationService {
	init() {
		const { OrderProduct, OrderHeader, Supplier, SupplierB1 } =
			this.entities;

		// TESTES
		// this.before("NEW", OrderProduct.drafts, async (req) =>
		// 	console.log("teste 1 OrderProduct", req.data)
		// );
		// this.before("CANCEL", OrderProduct.drafts, async (req) =>
		// 	console.log("teste 2 OrderProduct", req.data)
		// );
		// this.before("EDIT", OrderProduct.drafts, async (req) =>
		// 	console.log("teste 3 OrderProduct", req.data)
		// );
		// this.before("SAVE", OrderProduct.drafts, async (req) =>
		// 	console.log("teste 4 OrderProduct", req.data)
		// );
		// this.before("CREATE", OrderProduct.drafts, async (req) =>
		// 	console.log("teste 5 OrderProduct", req.data)
		// );
		// this.before("READ", OrderProduct.drafts, async (req) =>
		// 	console.log("teste 6 OrderProduct", req.data)
		// );
		// this.before("UPDATE", OrderProduct.drafts, async (req) =>
		// 	console.log("teste 7 OrderProduct", req.data)
		// );
		// this.before("DELETE", OrderProduct.drafts, async (req) =>
		// 	console.log("teste 8 OrderProduct", req.data)
		// );

		this.after(
			["CREATE", "UPDATE", "DELETE"],
			OrderProduct.drafts,
			async (data, req) => {
				const orderProducts = await SELECT.from(
					OrderProduct.drafts
				).where({ order_ID: data.order_ID ?? req.data.order_ID });
				const totalQuantity = orderProducts.reduce(
					(sum, product) =>
						(sum += product.unitCost * product.quantity),
					0
				);

				await UPDATE(OrderHeader.drafts)
					.set({ total: totalQuantity })
					.where({ ID: data.order_ID ?? req.data.order_ID });
			}
		);

		this.before("UPDATE", OrderProduct.drafts, async (req) => {
			// Manipula o valor total do item
			const orderProducts = await SELECT.from(OrderProduct.drafts).where({
				order_ID: req.data.order_ID,
			});
			const totalQuantity = orderProducts.reduce(
				(sum, product) => sum + product.quantity,
				0
			);

			await UPDATE(OrderHeader)
				.set({ total: totalQuantity })
				.where({ ID: req.data.order_ID });

			if (req.data.quantity < 0) {
				req.error({
					code: "QUANTITY_NEGATIVE",
					message: `Quantity cannot be negative (${req.data.quantity})`,
					target: "quantity",
					statusCode: 418,
				});
			}

			if (req.data.quantity || req.data.unitCost) {
				const oItem = await SELECT.from(
					OrderProduct.drafts,
					req.data.ID
				); // se fosse where, seria um array, mesmo que com 1 registro

				const quantity = req.data.quantity ?? oItem.quantity;
				const unitCost = req.data.unitCost ?? oItem.unitCost;

				req.data.total = quantity * unitCost;
			}
		});

		this.on("approveOrder", async (req) => {
			const order_ID = req.params[0].ID;
			const status_code = req.data.status_code;

			console.log("orderID" + order_ID);
			console.log("status_code" + status_code);

			if (order_ID && status_code) {
				{
					return UPDATE(OrderHeader, order_ID).with({ status_code });
				}
			}
		});

		this.on("READ", Supplier, async (req) => {
			const sapb1 = await cds.connect.to("API_B1_SERVICE_LAYER");

			return sapb1.run(req.query);

			// aqui passa externo direto por que é um serviço externo e ele já consegue rodar a query
		});

		this.on("READ", SupplierB1, async (req) => {
			const sapb1 = await cds.connect.to("API_B1_SERVICE_LAYER");

			return sapb1.run(req.query);

			// aqui passa externo direto por que é um serviço externo e ele já consegue rodar a query
		});

		return super.init();
	}
}

module.exports = { OrderService };
