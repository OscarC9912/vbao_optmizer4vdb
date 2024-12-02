from graphviz import Digraph
import numpy as np
from ast import literal_eval
import ast

def visualize_nested_plan(plan, filename, render=True):
    """
    Visualizes a deeply nested execution plan using Graphviz.

    Args:
        plan (dict): The execution plan as a nested dictionary.
        filename (str): The output filename for the visualization (without extension).
        render (bool): Whether to render and open the graph after generation.

    Returns:
        None
    """
    def add_node(dot, node, parent_id=None):
        """
        Recursively add nodes and edges to the graph.
        """
        # Create a unique node ID
        node_id = str(id(node))
        
        # Extract node details
        node_type = node.get("Node Type", "Unknown")
        node_type_id = node.get("Node Type ID", "N/A")
        total_cost = node.get("Total Cost", "N/A")
        plan_rows = node.get("Plan Rows", "N/A")
        relation_name = node.get("Relation Name", "")
        
        # Create a label for the node
        label = f"{node_type} ({node_type_id})\nCost: {total_cost}\nRows: {plan_rows}"
        if relation_name:
            label += f"\nRelation: {relation_name}"
        
        # Add the node to the graph
        dot.node(node_id, label)
        
        # Connect to the parent node if applicable
        if parent_id:
            dot.edge(parent_id, node_id)
        
        # Process child nodes in "Plans"
        for child in node.get("Plans", []):
            add_node(dot, child, node_id)
    
    # Initialize the Graphviz Digraph
    dot = Digraph(comment="Execution Plan", format="png")
    
    # Start with the root plan
    root_plan = plan.get("Plan", None)
    if root_plan:
        add_node(dot, root_plan)
    
    # Save and optionally render the graph
    dot.render(filename, view=render)
    
    
def file_reader(filepath):
    """
    Reads the file and converts it into a Python object, handling NumPy arrays.
    """
    with open(filepath, "r") as file:
        content = file.read()
    
    # Replace NumPy array syntax with JSON-compatible list syntax
    content = content.replace("array(", "").replace(")", "")
    
    try:
        # Convert the content to a Python object
        parsed_content = ast.literal_eval(content)
        return parsed_content
    except Exception as e:
        raise ValueError(f"Error parsing the file: {e}")

def to_numpy_array(data):
    """
    Recursively converts lists into NumPy arrays where applicable.
    """
    if isinstance(data, list):
        return np.array(data)
    elif isinstance(data, tuple):
        return tuple(to_numpy_array(item) for item in data)
    elif isinstance(data, dict):
        return {key: to_numpy_array(value) for key, value in data.items()}
    return data
    
    
def visualize_vector_tree(tree, filename, render=False):
    """
    Visualizes a nested vector tree structure using Graphviz.

    Parameters:
    - tree: The nested structure to visualize.
    - filename: The name of the output file.
    - render: Whether to display the tree after rendering.

    Returns:
    - None
    """
    dot = Digraph(format="png")
    node_counter = 0

    def add_node(parent_id, subtree):
        nonlocal node_counter

        # Extract node content
        vector, *children = subtree
        node_id = f"node_{node_counter}"
        node_counter += 1

        # Represent vector and value succinctly
        vector_text = ", ".join(f"{v:.3f}" for v in vector[:5]) + "..."
        dot.node(node_id, label=vector_text)

        # If this node has a parent, create an edge
        if parent_id is not None:
            dot.edge(parent_id, node_id)

        # Process children
        for child in children:
            if isinstance(child, tuple):
                add_node(node_id, child)
            else:
                child_id = f"node_{node_counter}"
                node_counter += 1
                dot.node(child_id, label=str(child))
                dot.edge(node_id, child_id)

    # Start recursion
    add_node(None, tree)

    # Render the visualization
    dot.render(filename, view=render)


def file_reader(file_path):
    content = None
    with open(file_path) as fdata:
        content = fdata.read()
    content = literal_eval(content)
    
    *plans, buffer = content
    
    subfolder_name = file_path.split('/')[-1].split('.')[0]
    
    for i in range(len(plans)):
        visualize_vector_tree(plans[i], f"/home/zchenhj/workspace/vBao/plans/vis_vec/{subfolder_name}/plan_{i}", render=True)



if __name__ == '__main__':
    file_reader('/home/zchenhj/workspace/vBao/plans/vec/q1_original.txt')
        
    