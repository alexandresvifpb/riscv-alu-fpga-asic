# ==========================================
# DIRETÓRIOS
# ==========================================

RTL_DIR=rtl
TB_DIR=tb
FPGA_DIR=rtl

SIM_DIR=sim
SIM_RTL_DIR=$(SIM_DIR)/rtl
SIM_GL_DIR=$(SIM_DIR)/gl
WAVE_DIR=$(SIM_DIR)/waves

# ==========================================
# CRIAR DIRETÓRIOS
# ==========================================

dirs:
	mkdir -p $(SIM_RTL_DIR)
	mkdir -p $(SIM_GL_DIR)
	mkdir -p $(WAVE_DIR)

# ==========================================
# LISTA DE RTL
# ==========================================

RTL_COMMON = \
	$(RTL_DIR)/alu.v \
	$(RTL_DIR)/input_register.v \
	$(RTL_DIR)/output_register.v \
	$(RTL_DIR)/debouncer.v \
	$(RTL_DIR)/edge_detector.v

RTL_TOP = \
	$(RTL_COMMON) \
	$(RTL_DIR)/binary_calc_top.v

RTL_FPGA = \
	$(RTL_TOP) \
	$(RTL_DIR)/binary_calc_top_fpga.v \
	$(RTL_DIR)/clock_divider.v

# ==========================================
# SIMULAÇÃO UNITÁRIA
# ==========================================

sim_alu: dirs
	iverilog -g2012 -Wall \
	-o $(SIM_RTL_DIR)/alu.vvp \
	$(RTL_DIR)/alu.v \
	$(TB_DIR)/alu_tb.v
	vvp $(SIM_RTL_DIR)/alu.vvp

sim_input_register: dirs
	iverilog -g2012 -Wall \
	-o $(SIM_RTL_DIR)/input_register.vvp \
	$(RTL_DIR)/input_register.v \
	$(TB_DIR)/input_register_tb.v
	vvp $(SIM_RTL_DIR)/input_register.vvp

sim_output_register: dirs
	iverilog -g2012 -Wall \
	-o $(SIM_RTL_DIR)/output_register.vvp \
	$(RTL_DIR)/output_register.v \
	$(TB_DIR)/output_register_tb.v
	vvp $(SIM_RTL_DIR)/output_register.vvp

sim_debouncer: dirs
	iverilog -g2012 -Wall \
	-o $(SIM_RTL_DIR)/debouncer.vvp \
	$(RTL_DIR)/debouncer.v \
	$(TB_DIR)/debouncer_tb.v
	vvp $(SIM_RTL_DIR)/debouncer.vvp

sim_edge_detector: dirs
	iverilog -g2012 -Wall \
	-o $(SIM_RTL_DIR)/edge_detector.vvp \
	$(RTL_DIR)/edge_detector.v \
	$(TB_DIR)/edge_detector_tb.v
	vvp $(SIM_RTL_DIR)/edge_detector.vvp

sim_clock_divider: dirs
	iverilog -g2012 -Wall \
	-o $(SIM_RTL_DIR)/clock_divider.vvp \
	$(RTL_DIR)/clock_divider.v \
	$(TB_DIR)/clock_divider_tb.v
	vvp $(SIM_RTL_DIR)/clock_divider.vvp

# ==========================================
# INTEGRAÇÃO (ASIC CORE)
# ==========================================

sim_top: dirs
	iverilog -g2012 -Wall \
	-o $(SIM_RTL_DIR)/binary_calc_top.vvp \
	$(RTL_TOP) \
	$(TB_DIR)/binary_calc_top_tb.v
	vvp $(SIM_RTL_DIR)/binary_calc_top.vvp

# ==========================================
# SISTEMA (FPGA)
# ==========================================

sim_fpga: dirs
	iverilog -g2012 -Wall \
	-o $(SIM_RTL_DIR)/binary_calc_top_fpga.vvp \
	$(RTL_FPGA) \
	$(TB_DIR)/binary_calc_top_fpga_tb.v
	vvp $(SIM_RTL_DIR)/binary_calc_top_fpga.vvp

# ==========================================
# LEGACY (mantido para compatibilidade)
# ==========================================

sim_legacy: dirs
	iverilog -g2012 -Wall \
	-o $(SIM_RTL_DIR)/legacy.vvp \
	$(RTL_DIR)/*.v \
	$(TB_DIR)/calculator_top_tb.v \
	$(TB_DIR)/de1_soc_top_tb.v
	vvp $(SIM_RTL_DIR)/legacy.vvp

# ==========================================
# EXECUÇÃO EM LOTE
# ==========================================

# Módulos auxiliares (infraestrutura)
sim_aux_modules: \
	sim_input_register \
	sim_output_register \
	sim_debouncer \
	sim_edge_detector \
	sim_clock_divider

# Fluxo completo (o que realmente importa no projeto)
sim_all: \
	sim_alu \
	sim_aux_modules \
	sim_top \
	sim_fpga

# ==========================================
# WAVEFORMS
# ==========================================

wave_alu:
	gtkwave $(WAVE_DIR)/alu_tb.vcd

wave_input_register:
	gtkwave $(WAVE_DIR)/input_register_tb.vcd

wave_output_register:
	gtkwave $(WAVE_DIR)/output_register_tb.vcd

wave_debouncer:
	gtkwave $(WAVE_DIR)/debouncer_tb.vcd

wave_edge_detector:
	gtkwave $(WAVE_DIR)/edge_detector_tb.vcd

wave_clock_divider:
	gtkwave $(WAVE_DIR)/clock_divider_tb.vcd

wave_top:
	gtkwave $(WAVE_DIR)/binary_calc_top_tb.vcd

wave_fpga:
	gtkwave $(WAVE_DIR)/binary_calc_top_fpga_tb.vcd

# ==========================================
# LINT
# ==========================================

lint:
	verilator --lint-only -Wall \
	$(RTL_DIR)/*.v

# ==========================================
# LIMPEZA
# ==========================================

clean:
	rm -rf $(SIM_DIR)/*

# ==========================================
# HELP
# ==========================================

help:
	@echo ""
	@echo "========== UNITÁRIO =========="
	@echo "make sim_alu"
	@echo "make sim_input_register"
	@echo "make sim_output_register"
	@echo "make sim_debouncer"
	@echo "make sim_edge_detector"
	@echo "make sim_clock_divider"
	@echo ""
	@echo "========== INTEGRAÇÃO =========="
	@echo "make sim_top"
	@echo ""
	@echo "========== SISTEMA =========="
	@echo "make sim_fpga"
	@echo ""
	@echo "========== LEGACY =========="
	@echo "make sim_legacy"
	@echo ""
	@echo "========== WAVE =========="
	@echo "make wave_top"
	@echo "make wave_fpga"
	@echo ""
	@echo "========== OUTROS =========="
	@echo "make lint"
	@echo "make clean"
	@echo ""

