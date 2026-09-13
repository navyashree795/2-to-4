# 2-to-4 Line Decoder with Enable

A digital design and simulation project for a **2-to-4 Line Decoder with Active-High Enable** implemented in Verilog HDL. This project includes RTL code, a comprehensive testbench, waveform dump setup (VCD), and instructions for both local open-source simulation tools (Icarus Verilog / GTKWave) and Cadence Lab EDA tools.

---

## 📌 Overview

A 2-to-4 line decoder takes a 2-bit binary input $A = \{A_1, A_0\}$ and decodes it into one of four unique active-high output lines $Y = \{Y_3, Y_2, Y_1, Y_0\}$. The design includes an active-high Enable (`en`) input:
- When **`en = 0`**, the decoder is disabled and all outputs are `0000`.
- When **`en = 1`**, the output corresponding to the binary value of input `a` is set to `1` (HIGH), while all other outputs remain `0` (LOW).

---

## 📊 Truth Table

| Enable (`en`) | Input $A_1$ | Input $A_0$ | Output $Y_3$ | Output $Y_2$ | Output $Y_1$ | Output $Y_0$ | Active Line |
|:-------------:|:-----------:|:-----------:|:------------:|:------------:|:------------:|:------------:|:-----------:|
| 0             | X           | X           | 0            | 0            | 0            | 0            | None (Disabled) |
| 1             | 0           | 0           | 0            | 0            | 0            | 1            | $Y_0$ |
| 1             | 0           | 1           | 0            | 0            | 1            | 0            | $Y_1$ |
| 1             | 1           | 0           | 0            | 1            | 0            | 0            | $Y_2$ |
| 1             | 1           | 1           | 1            | 0            | 0            | 0            | $Y_3$ |

*(X = Don't Care)*

---

## 📁 Repository Structure

```text
.
├── decoder_2to4.v         # Verilog RTL module for 2-to-4 decoder
├── tb_decoder_2to4.v      # Verilog testbench with GTKWave / VCD dump setup
├── decoder_results.vcd    # Generated Value Change Dump file for waveform viewer
├── README.md              # Project documentation
```

---

## 🔬 Implementation Details

### Module Definition (`decoder_2to4.v`)
- **Inputs:**
  - `a [1:0]`: 2-bit input selection lines ($A_1, A_0$).
  - `en`: 1-bit active-high enable signal.
- **Output:**
  - `y [3:0]`: 4-bit decoded output bus ($Y_3, Y_2, Y_1, Y_0$).

---

## 🚀 How to Run Simulation

### Method 1: Open-Source EDA Tools (Icarus Verilog & GTKWave)

1. **Compile the Verilog RTL and Testbench:**
   ```bash
   iverilog -o design.vvp decoder_2to4.v tb_decoder_2to4.v
   ```

2. **Run the Simulation:**
   ```bash
   vvp design.vvp
   ```

3. **View Waveforms in GTKWave:**
   ```bash
   gtkwave decoder_results.vcd
   ```

---

### Method 2: College Cadence Lab Workflow

This design was also verified and implemented in the **Cadence Lab Environment**:

#### A. Digital Simulation via Cadence NC-Verilog / Xcelium (`xmverilog` / `ncverilog`)
1. Open the terminal in your Cadence working directory.
2. Run simulation with GUI / waveform viewer:
   ```bash
   ncverilog +gui +access+rwc decoder_2to4.v tb_decoder_2to4.v
   # or with Xcelium:
   xrun -gui -access +rwc decoder_2to4.v tb_decoder_2to4.v
   ```
3. Open SimVision waveform window to analyze signals (`en`, `a[1:0]`, `y[3:0]`).

#### B. Schematic & Layout in Cadence Virtuoso (Custom IC Design Flow)
1. **Library & Cellview Setup:**
   - Launch Cadence Virtuoso (`virtuoso &`).
   - Create a new library and cellview `decoder_2to4` (type: `schematic`).
2. **Schematic Entry:**
   - Instantiate logic gates (NOT, AND gates) matching the boolean equations:
     - $Y_0 = en \cdot \overline{A_1} \cdot \overline{A_0}$
     - $Y_1 = en \cdot \overline{A_1} \cdot A_0$
     - $Y_2 = en \cdot A_1 \cdot \overline{A_0}$
     - $Y_3 = en \cdot A_1 \cdot A_0$
   - Add input/output pins (`a<1:0>`, `en`, `y<3:0>`, `VDD`, `GND`).
   - Check and Save schematic (clean DRC/ERC).
3. **Symbol Creation:**
   - Generate symbol view (`Create -> CellView -> From CellView`).
4. **Transient Simulation (Spectre / ADE L / ADE Explorer):**
   - Create a test schematic `tb_decoder_2to4` with `vpulse`/`vbit` and `vdc` sources.
   - Run Transient Analysis and verify voltage levels and timing delays.
5. **Physical Layout & Verification (Optional DRC / LVS):**
   - Generate Layout XL, route interconnects, and verify design rule checks (DRC) and layout-versus-schematic (LVS).

---

## 📈 Expected Simulation Output

```text
Time=0  | Enable=0 | Input=00 | Output=0000
Time=10 | Enable=0 | Input=11 | Output=0000
Time=20 | Enable=1 | Input=00 | Output=0001
Time=30 | Enable=1 | Input=01 | Output=0010
Time=40 | Enable=1 | Input=10 | Output=0100
Time=50 | Enable=1 | Input=11 | Output=1000
Time=60 | Enable=0 | Input=11 | Output=0000
Simulation Finished
```

---

## 👤 Author
- Implemented and verified in the **College Cadence Lab** and using **Icarus Verilog / GTKWave**.
