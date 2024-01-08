## Activity Statement 

The sixteenth activity was to create a project called riscvsingle, in the ModelSim tool (which should serve as a basis for simulating all the architecture's functionalities) and include all the files in the src folder and make changes to the dmem, imem, top and testbench entities, form:

i) include the request to use the riscv_pkg package, making all declarations visible;

ii) parameterize it based on RISCV_Data_Width (in the same way as was done with the riscvsingle entity);

iii) add the component declaration for the top, imem and dmem entities to the riscv_pkg package;

iv) present the result of the simulation.

### Development 

For all these files, namely dmem, imem, top and testbench, the riscv_pkg was made visible, the generic parameter named "Width" was added to the entity declaration and the port declarations were updated to use the generic Width. The architecture remained as was.

The component declarations were added into the riscv_pkg and it is as follows. 

```
-----------------------------
-- Top
component top is
  generic(
    Width : natural := RISCV_Data_Width
  );
  port(
    clk, reset:     in 			  BIT;
    WriteData, DataAdr:
                    buffer 		BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
    MemWrite: 	    buffer 		BIT
  );
end component top;
-----------------------------

-----------------------------
-- Testbench
component testbench is
  generic(
    RISCV_Data_Width : natural := 32
  );
end component testbench;
-----------------------------

-----------------------------
-- Imem
component imem is
  generic(
    RISCV_Data_Width : natural := 32
  );
  port(
    a: 	          in 			  BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
    rd:           out 			BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
);
end component imem;
-----------------------------

-----------------------------
-- Dmem
component dmem is
  generic(
    RISCV_Data_Width : natural := 32
  );
  port(
    clk, we:        in 			  BIT;
    a, wd:          in 			  BIT_VECTOR(RISCV_Data_Width - 1 downto 0);
    rd:             out 	        BIT_VECTOR(RISCV_Data_Width - 1 downto 0)
  );
end component dmem;
-----------------------------
```

At first, these files were compiled using Quartus II. They were defined as top level as it was done with the other entities. The only file that was not compiled in Quartus II was the testbench, as it has no entity. The compilation results are available in the "error_log.txt" file and the RTL in the "RTL_viewer.pdf" file on each corresponding directory inside of "/simulacoes_quartus" directory.

All files were added into ModelSim simulator, where the project was created in "../modelsim". The simulation in the testbench was successfully compiled. Both Error Log and Wave are available in this directory as "model_sim_error_log.txt" and "model_sim_wave.png", respectively.
