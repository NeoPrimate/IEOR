#import "/src/imports.typ": *

#title_page("Supply Chain")

= Inventory

#include("inventory/bullwhip.typ")

== Classification

#include("inventory/classification/abc.typ")

#include("inventory/classification/xyz.typ")

#include("inventory/classification/abc_xyz.typ")

#include("inventory/classification/fsn.typ")

#include("inventory/classification/ved.typ")

== Metrics

#include("inventory/metrics/inventory_turnover.typ")

#include("inventory/metrics/days_of_supply.typ")

#include("inventory/metrics/order_cycle_time.typ")

#include("inventory/metrics/perfect_order_rate.typ")

#include("inventory/metrics/stockout_rate.typ")

#include("inventory/metrics/gmroi.typ")

== Service Levels

#include("inventory/service_levels/cycle_service_level.typ")

#include("inventory/service_levels/fill_rate.typ")

#include("inventory/service_levels/ready_rate.typ")

== Stocks

#include("inventory/stocks/cycle_stock.typ")

#include("inventory/stocks/safety_stock.typ")

#include("inventory/stocks/anticipation_stock.typ")

#include("inventory/stocks/decoupling_stock.typ")

#include("inventory/stocks/pipeline_stock.typ")

== Newsvendor

#include("inventory/newsvendor/newsvendor.typ")

#include("inventory/newsvendor/discrete.typ")

#include("inventory/newsvendor/expected_profit.typ")

#include("inventory/newsvendor/shortage_penalty.typ")

#include("inventory/newsvendor/multiplicative.typ")

#include("inventory/newsvendor/multi_product.typ")

#include("inventory/newsvendor/capacity_constrained.typ")

== EOQ

#include("inventory/eoq/eoq.typ")

#include("inventory/eoq/epq.typ")

#include("inventory/eoq/backorders.typ")

#include("inventory/eoq/lost_sales.typ")

#include("inventory/eoq/quantity_discounts.typ")

#include("inventory/eoq/capacity_constrained.typ")

#include("inventory/eoq/joint_replenishment.typ")

#include("inventory/eoq/multi_echelon.typ")

#include("inventory/eoq/perishables.typ")

#include("inventory/eoq/wagner_whitin.typ")

== Policies

#include("inventory/policies/policies.typ")

#include("inventory/policies/base_stock.typ")

#include("inventory/policies/s_S.typ")

#include("inventory/policies/q_r.typ")

#include("inventory/policies/nQ_r.typ")

#include("inventory/policies/R_S.typ")

#include("inventory/policies/R_s_S.typ")

#include("inventory/policies/R_nQ_s.typ")
